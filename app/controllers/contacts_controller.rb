class ContactsController < ApplicationController

  def list
    respond_to do |wants|
      wants.json do
        contacts = Contact.all(:order => params[:order])
        render :text => { :records => to_hash(contacts),
                          :ids => contacts.map(&:id),
                          :count => contacts.size }.to_json
      end
    end
  end

  def show
    respond_to do |wants|
      wants.json do
        contacts = Contact.find(params[:id] || params[:ids].split(","))
        render :text => to_hash(contacts).to_json
      end
    end
  end

  def create
    respond_to do |wants|
      wants.json {
        response = []
        params[:records].each_pair do |record_id, record|
          record.delete(:id)
          guid = record.delete(:_guid)
          puts '-'*80
          puts '-'*80
          p record
          puts '-'*80
          puts '-'*80
          contact = Contact.new(record)
          contact.save
          response << {:_guid => guid, :id => contact.id}
        end

        render :text => response.to_json
      }
    end
  end

  def update
    respond_to do |wants|
      wants.json {
        records = ActiveSupport::JSON.decode(params[:records])

        records.each do |record|
          contact = Contact.find(record["guid"])
          contact.attributes = record.slice("firstName", "lastName")
          contact.save
        end

        head :ok
      }
    end
  end

  def destroy
    respond_to do |wants|
      wants.json {
        Contact.destroy(params[:id] || params[:ids].split(","))
        head :ok
      }
    end
  end

  private

  def to_hash(contacts)
    contacts = [contacts] unless contacts.is_a?(Array)
    contacts.map do |contact|
      { :id        => contact.id,
        :type      => contact.class.name,
        :firstName => contact.firstName,
        :lastName  => contact.lastName
      }
    end
  end

end
